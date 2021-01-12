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
		$this->data['booktypes'] = $this->Booktypes->get_all();
		$this->response($this->data);
	}

	public function index_post()
	{
		$val = array(
			'status_name'=>$this->post('status_name')
		);

		$id = $this->Booktypes->insert($val);
		$this->data['booktype'] = $this->Booktypes->get($id);
		$this->response($this->data,201);
	}

	public function index_put()
	{
		$val = array(
			'status_name'=>$this->put('status_name')
		);

		$id = $this->put('id');
		$this->Booktypes->update($id,$val);
		$this->data['booktype'] = $this->Booktypes->get($id);
		$this->response($this->data);
	}

	public function index_delete($id)
	{
		
		$this->data['booktype'] = $this->Booktypes->get($id);

		$this->load->model('books');

		$row = $this->books->get_by(['type_id'=>$id]);
		if($row){
			$this->data['message'] = 'Ready Data';
			$this->response($this->data);	
		}else{
			$this->data['message'] = 'Delete';
			$this->Booktypes->delete($id);
			$this->response($this->data);
		}
		
	}

}
