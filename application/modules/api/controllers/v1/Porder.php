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

        $limit = $this->get('limit') ?? 10;
        $offset = $this->get('offset') ?? 0;

        $this->porders->order_by('id','desc');
        $this->porders->limit($limit, $offset);
        $this->data['porders'] = $this->porders->get_all();
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
