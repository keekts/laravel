<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Ordersstatus extends MY_Model {

	public $_table = 'order_status';
	/*
	if table name referent model clas name
	 */
	public function __construct()
	{
		parent::__construct();
	}
}