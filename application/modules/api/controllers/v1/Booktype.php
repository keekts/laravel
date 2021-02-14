<?php
defined('BASEPATH') OR exit('No direct script access allowed');

require_once APPPATH . '/libraries/REST_Controller.php';

class Booktype extends REST_Controller {

	public function __construct()
	{
		parent::__construct();
		$this->load->model('Booktypes');
	}

	public function index_get()
	{
		$this->Booktypes->order_by('type_name');
		$this->data['booktypes'] = $this->Booktypes->get_all();
		$this->response($this->data);
	}

	private function id($id)
	{
		$this->data['booktype'] = $this->Booktypes->get($id);
	}

	public function index_post()
	{
		$val = array(
			'type_name'=>$this->post('type_name')
		);

		$id = $this->Booktypes->insert($val);
		$this->id($id);
		$this->response($this->data,201);
	}

	public function index_put()
	{
		$val = array(
			'type_name'=>$this->put('type_name')
		);

		$id = $this->put('id');
		$this->Booktypes->update($id,$val);
		$this->id($id);
		$this->response($this->data);
	}

	public function index_delete($id)
	{
		
		$this->id($id);

		$this->load->model('books');

		$row = $this->books->get_by(['type_id'=>$id]);
		if($row){
			$this->data['message'] = 'cannot delete';
			$this->response($this->data);	
		}else{
			$this->data['message'] = 'Deleted';
			$this->data['status'] = true;
			$this->Booktypes->delete($id);
			$this->response($this->data);
		}
		
	}

}
