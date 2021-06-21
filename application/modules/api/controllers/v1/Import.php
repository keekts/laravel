<?php
defined('BASEPATH') OR exit('No direct script access allowed');

require_once APPPATH . '/libraries/REST_Controller.php';

class Import extends REST_Controller {
	public function __construct()
	{
		parent::__construct();
		$this->load->model(['imports']);
	}

	public function index_get()
	{
		$id = $this->get('id');
		if($id > 0) {
			$this->data['order'] = $this->orders->get($id);
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
		$val = $this->post('input');
		$id = $this->imports->insert($val);
		$this->data['import'] = $this->imports->get($id);
		$this->response($this->data,201);
	}

	public function index_put()
	{
		$val = $this->put('input');
		$id = $this->put('id');
		$this->imports->update($id,$val);
		$this->data['order'] = $this->imports->get($id);
		$this->response($this->data);
	}

	public function index_delete($id=0)
	{
		$this->imports->delete($id);
		$this->data['message'] = 'deleted';
		$this->response($this->data);
	}


}