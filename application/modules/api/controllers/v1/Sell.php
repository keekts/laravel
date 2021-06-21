<?php
defined('BASEPATH') OR exit('No direct script access allowed');

require_once APPPATH . '/libraries/REST_Controller.php';

class Sell extends REST_Controller {
	public function __construct()
	{
		parent::__construct();
		$this->load->model(['sells','selldetails']);
	}

	public function index_get()
	{
		$id = $this->get('id');
		if($id > 0) {
			$this->data['sell'] = $this->sells->get($id);

			$sql = "select b.name,d.qty,d.price,order_id from books b inner join order_details d on d.book_id=b.id where order_id=$id";
			$this->data['details'] = $this->db->query($sql)->result();
			$this->response($this->data);
		}

		$limit = $this->get('limit') ?? 10;
		$offset = $this->get('offset') ?? 0;

		$this->sells->limit($limit,$offset);
		$this->data['orders'] = $this->sells->get_all();
		$this->response($this->data);
	}

	public function index_post()
	{
		$val = $this->post('input');
		$id = $this->sells->insert($val);
		$this->data['sell'] = $this->sells->get($id);
		$this->response($this->data,201);
	}

	public function index_put()
	{
		$val = $this->put('input');
		$id = $this->put('id');
		$this->sells->update($id,$val);
		$this->data['sell'] = $this->sells->get($id);
		$this->response($this->data);
	}

	public function index_delete($id=0)
	{
		$this->selldetails->delete_by(['sell_id'=>$id]);
		$this->sells->delete($id);
		$this->data['message'] = 'deleted';
		$this->response($this->data);
	}


}