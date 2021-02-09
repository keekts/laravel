<?php
defined('BASEPATH') OR exit('No direct script access allowed');

require_once APPPATH . '/libraries/REST_Controller.php';

class Order extends REST_Controller {
	public function __construct()
	{
		parent::__construct();
		$this->load->model(['orders','orderdetails']);
	}

	public function index_get()
	{
		$id = $this->get('id');
		if($id > 0) {
			$this->data['order'] = $this->orders->get($id);

			$sql = "select b.name,d.qty,d.price,order_id from books b inner join order_details d on d.book_id=b.id where order_id=$id";
			$this->data['details'] = $this->db->query($sql)->result();
			$this->response($this->data);
		}

		$limit = $this->get('limit') ?? 10;
		$offset = $this->get('offset') ?? 0;

		$this->orders->limit($limit,$offset);
		$this->data['orders'] = $this->orders->get_all();
		$this->response($this->data);
	}

	public function index_post()
	{

	}

	public function index_put()
	{
		$val = $this->put('order');
		$id = $this->put('id');
		$this->orders->update($id,$val);
		$this->data['order'] = $this->orders->get($id);
		$this->response($this->data);
	}

	public function index_delete($id=0)
	{
		$this->orders->delete_by(['order_id'=>$id]);
		$this->orders->delete($id);
		$this->data['message'] = 'deleted';
		$this->response($this->data);
	}


}