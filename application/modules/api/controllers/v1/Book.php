<?php
defined('BASEPATH') OR exit('No direct script access allowed');

require_once APPPATH . '/libraries/REST_Controller.php';

class Book extends REST_Controller {

	public function __construct()
	{
		parent::__construct();
		$this->load->model('books');
	}

	public function index_get()
	{
		$limit = $this->get('limit') ?: 10;
		$offset = $this->get('offset') ?: 0;

		$id = trim($this->get('id'));

		if ($id > 0) {
			$data = $this->books->get($id);
			$this->load->model('booktypes');
			$this->data['book_types'] = $this->booktypes->get_all();
			
			$this->data['book'] = $data;
			$this->response($this->data);
		}

		$search = trim($this->get('search'));

		$tag = trim($this->get('tag'));
		
		if ($tag) {
			$this->db->like('tag',$tag);
		}

		$typeId = trim($this->get('type_id'));
		if ($typeId) {
			$this->db->like('type_id',$typeId);
		}
		$this->books->limit($limit,$offset);
		$this->data['total'] = $this->books->count_all();
		
		
		if ($search) {
			$wh["name LIKE '%$search%' OR description LIKE '%$search%'"] = null;
			$data = $this->books->get_many_by($wh);
			$this->data['results'] = $data;
			$this->data['s'] = $wh;
			$this->books->limit($limit,$offset);
			$this->data['total'] = $this->books->count_by($wh);
			$this->response($this->data);
		}
		$this->books->limit($limit,$offset);

		$data = $this->books->get_all();

		$this->data['results'] = $data;
		$this->response($this->data);
	}

	public function id_get()
	{
		$id = $this->get('id');
		$book = $this->books->get($id);
		$this->data['book'] = $book;
		$this->books->limit(8);
		$this->data['books'] = $this->books->get_many_by(['type_id'=>$book->type_id,'id !='=>$id]);
		if(count($this->data['books']) < 1) {
			$this->books->order_by('RAND()');
			$this->data['books'] = $this->books->get_all();
		}
		$this->response($this->data);
	}

	public function qtyRow_get()
	{
		$limit = $this->get('limit') ?: 10;
		$this->books->limit($limit);
		$this->books->order_by('qty');
		$this->data['books'] =$this->books->get_all();
		$this->response($this->data);
	}

	public function index_post($value='')
	{
		# create data 
		$val['name'] = trim($this->post('name'));
		$val['description'] = trim($this->post('description'));
		$val['tag'] = trim($this->post('tag'));
		$val['code'] = trim($this->post('code'));
		$val['price'] = trim($this->post('price'));
		$val['price_cost'] = trim($this->post('price_cost'));
		$val['type_id'] = (int) trim($this->post('type_id'));

		if (!$val['name']) {
			$this->data['status'] = false;
			$this->data['message'] = 'name or code not value !';
			$this->response($this->data,400);
		}

		// with upload
		$upload = $this->uploadImage();
		if($upload){
			$imgagePath = $upload['folder']."/".$upload['file_name'];
			$imgageCover = $upload['folder']."/".$upload['raw_name'].'_thumb'.$upload['file_ext'];
			$val['cover'] = $imgagePath;
			$val['image'] = $imgagePath;
		}

		$id = $this->books->insert($val);
		$this->data['message'] = 'insert new row success';
		$this->data['book'] = $this->books->get($id);
		$this->response($this->data,201);
	}

	public function index_put($value='')
	{
		
		$data = $this->put('book');

		$allowed = ['tag','description','code','name','star','type_id','isbn','price','price_cost','price_discount','stock','author','detail'];
		$id = trim($this->put('id'));
		
		if(!$id) {
			$this->data['message'] = 'id not value !';
			$this->response($this->data,400);
		}

		// $book = array_filter(
		// 	$data,
		// 	function ($key) use ($allowed) {
		// 		return in_array($key, $allowed);
		// 	},
		// 	ARRAY_FILTER_USE_KEY
		// );

		if (!$data['name']) {
			$this->data['status'] = false;
			$this->data['message'] = 'name or code not value !';
			$this->response($this->data);
		}



		$this->books->update($id,$data);
		$this->data['book'] = $this->books->get($id);
		$this->data['message'] = 'update data success';
		$this->response($this->data);

	}

	public function index_delete($id=0)
	{
		# delete data by id
		$book =$this->books->get($id);
		$this->data['book'] = $book;

		$this->load->model(['selldetails','porderdetails']);

		$sell = $this->selldetails->count_by('book_id',$id);
		$porder = $this->porderdetails->count_by('book_id',$id);
		if($sell > 0 || $porder > 0){
			$this->data['status'] = false;
			$this->data['message'] = 'cannot delete';
			$this->response($this->data,400);
		}
		

		if($book->image) {
					// remove old image
			if(file_exists($book->image)) {
				@unlink($book->image);
			}
					// remove book cover
			if(file_exists($book->cover)) {
				@unlink($book->cover);
			}
		}

		$this->data['status'] = true;
		$this->books->delete($id);
		$this->data['message'] = 'delete success';
		$this->response($this->data);
	}

	public function uploadImage()
	{
		$this->load->helper('string');

		//Year in YYYY format.
		$year = date("Y/m/d");

		//Month in mm format, with leading zeros.
		$month = date("m");
		$directory = "uploads/$year";

		//If the directory doesn't already exists.
		if(!is_dir($directory)){
    //Create our directory.
			mkdir($directory, 0777, true);
		}


		$config['upload_path']          = $directory;
		$config['allowed_types']        = 'gif|jpg|png|jpeg|svg';
		// $config['max_size']             = 100;
		// $config['max_width']            = 1024;
		// $config['max_height']           = 768;
		$config['file_name'] = random_string('alnum',30);

		$this->load->library('upload', $config);


		if (!$this->upload->do_upload('file'))
		{
			$this->data['error'] = $this->upload->display_errors();
			return null;
		}else{
			$data = $this->upload->data();

			//Image Resizing 
			$config1['source_image'] = $data['full_path'];
			$config1['create_thumb'] = TRUE;
			$config1['width'] = 250;
			$config1['height'] = 300; 
			$config1['new_image'] =  $directory;//.'/'.$config1['width'].'x'.$config1['height'];
			$config1['maintain_ratio'] = FALSE;
			$data['folder'] = $directory;
			$this->data['image'] = $data;

			$this->load->library('image_lib', $config1); 
			$this->image_lib->resize();

			return $data;
			
		}
	}

	public function changeImage_post($value='')
	{
		$upload = $this->uploadImage();
		if($upload) {
			$id = $this->post('id');
			$book = $this->books->get($id);
			if($book) {
				if($book->image) {
					// remove old image
					if(file_exists($book->image)) {
						@unlink($book->image);
					}
					// remove book cover
					if(file_exists($book->cover)) {
						@unlink($book->cover);
					}
				}
				// update book cover and image
				$imgagePath = $upload['folder']."/".$upload['file_name'];
				$imgageCover = $upload['folder']."/".$upload['raw_name'].'_thumb'.$upload['file_ext'];

				$val = array('cover'=>$imgagePath,'image'=>$imgagePath);
				$this->books->update($id,$val);
				$this->data['message'] = 'update image success';

				$this->data['book'] = $this->books->get($id);

				$this->response($this->data);
			}
		}else{
			$this->response($this->data,400);
		}
	}

	public function upload_post()
	{
		$this->uploadImage();
		$this->response($this->data);
	}

}
