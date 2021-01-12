<?php
defined('BASEPATH') OR exit('No direct script access allowed');

require_once APPPATH . '/libraries/REST_Controller.php';

class Order extends REST_Controller {
	public function __construct()
	{
		parent::__construct();
		
	}

	public function index_get()
	{
		
	}

}
