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

		$id = trim($this->get('id'));

		if ($id > 0) {
			$data = $this->books->get($id);
			$this->data['results'] = $data;
			$this->response($this->data);
		}

		$search = trim($this->get('search'));
		if ($search) {
			$wh["name LIKE '%$search%' OR description LIKE '%$search%'"] = null;
			$data = $this->books->get_many_by($wh);
			$this->data['results'] = $data;
			$this->response($this->data);
		}

		$data = $this->books->get_all();

		$this->data['results'] = $data;
		$this->response($this->data);
	}

	public function index_post($value='')
	{
		# create data 
		$val['name'] = trim($this->post('name'));
		$val['description'] = trim($this->post('description'));
		$val['tag'] = trim($this->post('tag'));
		$val['code'] = trim($this->post('code'));

		if (!$val['name'] || !$val['code']) {
			$this->data['status'] = false;
			$this->data['message'] = 'name or code not value !';
			$this->response($this->data,400);
		}

		$id = $this->books->insert($val);
		$this->data['message'] = 'insert new row success';
		$this->data['book'] = $this->books->get($id);
		$this->response($this->data,201);
	}

	public function index_put($value='')
	{
		
		$data = $this->put('book');

		$allowed = ['tag','description','code','name'];

		$id = trim($this->put('id'));
		
		if(!$id) {
			$this->data['message'] = 'id not value !';
			$this->response($this->data,400);
		}

		$book = array_filter(
			$data,
			function ($key) use ($allowed) {
				return in_array($key, $allowed);
			},
			ARRAY_FILTER_USE_KEY
		);

		if (!$book['name'] || !$book['code']) {
			$this->data['status'] = false;
			$this->data['message'] = 'name or code not value !';
			$this->response($this->data,400);
		}

		$id = trim($this->put('id'));

		$this->books->update($id,$book);
		$this->data['book'] = $this->books->get($id);
		$this->data['message'] = 'update data success';
		$this->response($this->data);

	}

	public function index_delete($id=0)
	{
		# delete data by id
		$this->data['book'] = $this->books->get($id);
		$this->books->delete($id);
		$this->data['message'] = 'delete success';
		$this->response($this->data);
	}

	public function upload_post()
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
		$config['file_name'] = random_string('alnum',50);

		$this->load->library('upload', $config);


		if (!$this->upload->do_upload('file'))
		{
			$this->data['error'] = $this->upload->display_errors();
		}else{
			$data = $this->upload->data();
			$this->data['data'] = $data;
			//Image Resizing 
			$config1['source_image'] = $data['full_path'];
			$config1['create_thumb'] = TRUE;
			$config1['width'] = 250;
			$config1['height'] = 300; 
			$config1['new_image'] =  $directory;//.'/'.$config1['width'].'x'.$config1['height'];
			$config1['maintain_ratio'] = FALSE;

			$this->load->library('image_lib', $config1); 
			$this->image_lib->resize();
		}

		$this->response($this->data);
	}

}
