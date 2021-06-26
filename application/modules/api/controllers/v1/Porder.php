<?php
defined('BASEPATH') or exit('No direct script access allowed');

require_once APPPATH . '/libraries/REST_Controller.php';

class Porder extends REST_Controller
{
    public function __construct()
    {
        parent::__construct();
        $this->load->model(['porders', 'porderdetails']);
    }

    public function index_get()
    {
        $id = $this->get('id');
        if ($id > 0) {
            $this->load->model('suppliers');
            $porder = $this->porders->get($id);
            $this->data['porder'] = $porder;
            $this->data['supplier'] = $this->suppliers->get($porder->supplier_id);

            $sql = "select b.name,b.cover,d.* from books b inner join 
             purchaser_order_details d on d.book_id=b.id where purchaser_order_id=$id";
            $this->data['details'] = $this->db->query($sql)->result();
            $this->response($this->data);
        }

        $limit = $this->get('limit') ?: 10;
        $offset = $this->get('offset') ?: 0;

        // $this->db->order_by('p.id','desc');
        // $this->db->limit($limit, $offset);
        $searchSql = '';
        $search = $this->get('search');
        if($search) {
            $searchSql = " where p.id LIKE '%$search%' ";
        }

        $sqlpOrder = "select e.first,e.last,p.* from purchaser_orders p left join
         employees e on e.id=p.emp_id  $searchSql  order by p.id desc limit $offset,$limit 
        ";
        $this->data['porders'] = $this->db->query($sqlpOrder)->result();
        $this->response($this->data);
    }

    public function index_post()
    {
        $val = $this->post('input');
        $id = $this->porders->insert($val);
        $this->data['porder'] = $this->porders->get($id);
        $this->response($this->data, 201);
    }

    public function index_put()
    {
        $val = $this->put('input');
        $id = $this->put('id');
        $this->porders->update($id, $val);
        $this->data['order'] = $this->porders->get($id);
        $this->response($this->data);
    }

    public function index_delete($id = 0)
    {
        $row = $this->porderdetails->delete_by(['purchaser_order_id' => $id]);
        if ($row) {
            $this->response($this->data, 400);
        } else {
            $this->porders->delete($id);
            $this->data['message'] = 'deleted';
            $this->response($this->data);
        }
    }

}
