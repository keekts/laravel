<?php
defined('BASEPATH') OR exit('No direct script access allowed');

require_once APPPATH . '/libraries/REST_Controller.php';

class Welcome extends REST_Controller {
	public function __construct()
	{
		parent::__construct();
	}

	public function index_get()
	{
		$this->data['message'] = 'API Version 1.0';
		$this->data['data'] = '';
		$this->response($this->data);
	}

}
