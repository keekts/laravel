<?php
defined('BASEPATH') or exit('No direct script access allowed');

require_once APPPATH . '/libraries/REST_Controller.php';

class Sell extends REST_Controller
{
    public function __construct()
    {
        parent::__construct();
        $this->load->model(['sells', 'selldetails']);
    }

    public function index_get()
    {
        $id = $this->get('id');
        if ($id > 0) {
            $this->load->model(['customers', 'employees']);

            $sell = $this->sells->get($id);
            $this->data['sell'] = $sell;
            $this->data['customer'] = $this->customers->get($sell->customer_id);
            $this->data['emp'] = $this->employees->get($sell->emp_id);

            $sql = "select b.name,b.cover,d.* from books b inner join
			 sell_details d on d.book_id=b.id where sell_id=$id";
            $this->data['items'] = $this->db->query($sql)->result();
            $this->response($this->data);
        }

        $limit = $this->get('limit') ?? 10;
        $offset = $this->get('offset') ?? 0;

        $search = $this->get('search');
        $searchSql = '';
        if ($search) {
            $searchSql = " where s.id like '$search%' or c.first like '%$search%' ";
        }

        $sql = "select s.*,c.first,c.last from sells s
				inner join customers c on s.customer_id=c.id $searchSql
			 order by sell_date desc  limit $offset,$limit ";
        $this->data['sells'] = $this->db->query($sql)->result();
        $this->data['total'] = $this->sells->count_all();

        $this->response($this->data);
    }

    public function status_get()
    {

        $limit = $this->get('limit') ?? 10;
        $offset = $this->get('offset') ?? 0;
        $status = $this->get('status') ?? 'order';

        $search = $this->get('search');
        $searchSql = '';
        if ($search) {
            $searchSql = " where s.id like '$search%' or c.first like '%$search%' and (status='$status') ";
        }else{
            $searchSql = " where status='$status'";
        }

        $sql = "select s.*,c.first,c.last from sells s
				inner join customers c on s.customer_id=c.id $searchSql
			 order by sell_date desc  limit $offset,$limit ";
        $this->data['sells'] = $this->db->query($sql)->result();
        $this->data['total'] = $this->sells->count_by('status',$status);

        $this->response($this->data);

    }

    public function index_post()
    {
        $val = $this->post('input');
        $id = $this->sells->insert($val);
        $this->data['sell'] = $this->sells->get($id);
        $this->response($this->data, 201);
    }

    public function index_put()
    {
        $val = $this->put('input');
        $id = $this->put('id');
        $this->sells->update($id, $val);
        $this->data['sell'] = $this->sells->get($id);
        $this->response($this->data);
    }

    public function index_delete($id = 0)
    {
        $this->selldetails->delete_by(['sell_id' => $id]);
        $this->sells->delete($id);
        $this->data['message'] = 'deleted';
        $this->response($this->data);
    }

}
