<?php
defined('BASEPATH') OR exit('No direct script access allowed');

require_once APPPATH . '/libraries/REST_Controller.php';

class Supplier extends REST_Controller {
	public function __construct()
	{
		parent::__construct();
		$this->load->model('suppliers');
		
	}

	public function index_get()
	{
		$limit = $this->get('limit') ?? 100;
		$offset = $this->get('offset') ?? 0;
		$this->suppliers->limit($limit,$offset);

		$search = $this->get('search');
		if ($search) {
			$this->db->where(" name LIKE '%$search%' OR phone LIKE '%$search%' ");
		}

		$this->data['suppliers'] = $this->suppliers->get_all();
		$this->response($this->data);
	}

	public function index_post()
	{
		$val = $this->post('input');
		$id = $this->suppliers->insert($val);
		$this->data['supplier'] = $this->suppliers->get($id);
		$this->response($this->data,201);
	}

	public function index_put()
	{
		$val = $this->put('input');

		$id = $this->put('id');

		$this->suppliers->update($id,$val);

		$this->data['supplier'] = $this->suppliers->get($id);
		$this->response($this->data);
	}

	public function index_delete($id)
	{
		$this->load->model('porders');
		$wh = array('supplier_id'=>$id);
		$order = $this->porders->get_by($wh);
		if($order) {
			$this->data['status'] = false;
			$this->data['message'] = 'canot delete';
			$this->response($this->data,400);
		}

		$this->data['supplier'] = $this->suppliers->get($id);
		$this->suppliers->delete($id);
		$this->response($this->data);
	}

}
