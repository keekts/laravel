<?php
defined('BASEPATH') OR exit('No direct script access allowed');

require_once APPPATH . '/libraries/REST_Controller.php';

class Porderdetail extends REST_Controller {

	public function __construct()
	{
		parent::__construct();
		$this->load->model('porderdetails');
	}

	public function index_get()
	{
		
	}

	public function index_post()
	{
		$val = $this->post('input');
		$id = $this->porderdetails->insert($val);
		$this->data['details'] = $this->porderdetails->get($id);
		$this->response($this->data,201);
	}

	public function inserts_post()
	{
		$val = $this->post('input');
		$this->porderdetails->insert_many($val);
		$this->response($this->data,201);
	}

	public function index_put()
	{
		$val = $this->put('input');
		$id = $this->put('id');

		$this->porderdetails->update($id,$val);

		$this->data['detail'] = $this->porderdetails->get($id);
		$this->response($this->data);
	}

	public function index_delete($id=0)
	{
		$this->data['message'] = 'deleted';
		$this->porderdetails->delete($id);
		$this->response($this->data);
	}

}
