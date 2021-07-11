<?php
defined('BASEPATH') or exit('No direct script access allowed');

require_once APPPATH . '/libraries/REST_Controller.php';

class Customer extends REST_Controller
{
    public function __construct()
    {
        parent::__construct();
        $this->load->model('customers');

    }

    public function index_get()
    {
        $limit = $this->get('limit') ?? 100;
        $offset = $this->get('offset') ?? 0;
        $this->customers->limit($limit, $offset);

        $id = $this->get('id');
        if ($id) {
            $this->data['customer'] = $this->customers->get($id);
            $this->response($this->data);
        }

        $search = $this->get('search');
        if ($search) {
            $this->db->where(" first LIKE '%$search%' OR phone LIKE '%$search%' ");
        }

        $this->data['customers'] = $this->customers->get_all();
        $this->response($this->data);
    }

    public function index_post()
    {
        $val = $this->post('input');
        $id = $this->customers->insert($val);
        $this->data['customer'] = $this->customers->get($id);
        $this->response($this->data, 201);
    }

    public function index_put()
    {
        $val = $this->put('input');

        $id = $this->put('id');

        $this->customers->update($id, $val);

        $this->data['customer'] = $this->customers->get($id);
        $this->response($this->data);
    }

    public function index_delete($id)
    {
        $this->load->model('sells');
        $wh = array('customer_id' => $id);
        $order = $this->sells->get_by($wh);
        if ($order) {
            $this->data['status'] = false;
            $this->data['message'] = 'canot delete';
            $this->response($this->data, 400);
        }

        $this->data['customer'] = $this->customers->get($id);
        $this->customers->delete($id);
        $this->response($this->data);
    }

}
