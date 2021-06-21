<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Users extends MY_Model {

	public $_table = 'employees';
	/*
	if table name referent model clas name
	 */
	public function __construct()
	{
		parent::__construct();
	}
}
