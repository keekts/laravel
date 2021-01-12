<?php
defined('BASEPATH') OR exit('No direct script access allowed');

require_once APPPATH . '/libraries/REST_Controller.php';

class Orderstatus extends REST_Controller {
	public function __construct()
	{
		parent::__construct();
		$this->load->model('Ordersstatus');
	}

	public function index_get()
	{
		$this->data['orderstatus'] = $this->Ordersstatus->get_all();
		$this->response($this->data);
	}

	public function index_post()
	{
		$val = array(
			'status_name'=>$this->post('status_name')
		);

		$id = $this->Ordersstatus->insert($val);
		$this->data['orderstatus'] = $this->Ordersstatus->get($id);
		$this->response($this->data,201);
	}

	public function index_put()
	{
		$val = array(
			'status_name'=>$this->put('status_name')
		);

		$id = $this->put('id');
		$this->Ordersstatus->update($id,$val);
		$this->data['orderstatus'] = $this->Ordersstatus->get($id);
		$this->response($this->data);
	}

	public function index_delete($id)
	{
		
		$this->data['orderstatus'] = $this->Ordersstatus->get($id);

		$this->load->model('orders');

		$row = $this->orders->get_by(['status_id'=>$id]);
		if($row){
			$this->data['message'] = 'Ready Data';
			$this->response($this->data);	
		}else{
			$this->data['message'] = 'Delete';
			$this->Ordersstatus->delete($id);
			$this->response($this->data);
		}
		
	}

}
