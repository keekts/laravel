<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Orders extends MY_Model {

	public $_table = 'purchaser_orders';

	public function __construct()
	{
		parent::__construct();
	}
}
