<?php
defined('BASEPATH') OR exit('No direct script access allowed');

require_once APPPATH . '/libraries/REST_Controller.php';

class Orderdetail extends REST_Controller {

	public function __construct()
	{
		parent::__construct();
		$this->load->model('orderdetails');
	}

	public function index_get()
	{
		
	}

	public function index_post()
	{
		$val = $this->post('input');
		$this->orderdetails->insert($id,$val);
		$this->response($this->data,201);
	}

	public function index_put()
	{
		$val = $this->put('input');
		$id = $this->put('id');

		$this->orderdetails->update($id,$val);

		$this->data['details'] = $this->orderdetails->get($id);
		$this->response($this->data);
	}

	public function index_delete($id=0)
	{
		$this->data['message'] = 'deleted';
		$this->orderdetails->delete($id);
		$this->response($this->data);
	}

}
