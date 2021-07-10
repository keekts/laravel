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
			$this->data['import'] = $this->orders->get($id);
			$this->response($this->data);
		}

		$limit = $this->get('limit') ?: 10;
		$offset = $this->get('offset') ?: 0;

		$search  = $this->get('search');
		$searchSql = '';
		if($search) {
			$searchSql = " where p.purchaser_order_id like '$search%' or b.name like '%$search%' ";
		}

		$sql = " select b.name,b.qty as stock,b.cover,b.price as book_price,
		 i.*,p.post_to_stock,p.purchaser_order_id
		 from purchaser_order_details p inner join imports i 
		 on p.id=i.purchaser_detail_id inner join books b on b.id=p.book_id 
		 $searchSql order by i.id desc  
		 limit $offset,$limit 
		";
		$this->data['imports'] = $this->db->query($sql)->result();
		$this->data['total'] = $this->imports->count_all();
		$this->response($this->data);
	}

	public function index_post()
	{
		$val = $this->post('input');
		$id = $this->imports->insert($val);

		$bookid = $this->post('book_id');
		$qty = (int) $val['qty'];
		$price = $val['price'];
		$sqlBook = "update books set qty=(qty+$qty) , price_cost=$price where id=$bookid";

		$purchaser_detail_id  = $val['purchaser_detail_id'];
		$sqlUpdatePdetail = "update purchaser_order_details set post_to_stock=$qty 
		 where id=$purchaser_detail_id";
		$this->db->query($sqlBook);
		$this->db->query($sqlUpdatePdetail);
	

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