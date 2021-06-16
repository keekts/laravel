<?php
defined('BASEPATH') OR exit('No direct script access allowed');

require_once APPPATH . '/libraries/REST_Controller.php';

class Purchaseorderdetail extends REST_Controller {

	public function __construct()
	{
		parent::__construct();
		$this->load->model('purchaseorderdetails');
	}

	public function index_get()
	{
		
	}

	public function index_post()
	{
		$val = $this->post('input');
		$this->purchaseorderdetails->insert($id,$val);
		$this->response($this->data,201);
	}

	public function index_put()
	{
		$val = $this->put('input');
		$id = $this->put('id');

		$this->purchaseorderdetails->update($id,$val);

		$this->data['details'] = $this->purchaseorderdetails->get($id);
		$this->response($this->data);
	}

	public function index_delete($id=0)
	{
		$this->data['message'] = 'deleted';
		$this->purchaseorderdetails->delete($id);
		$this->response($this->data);
	}

}
