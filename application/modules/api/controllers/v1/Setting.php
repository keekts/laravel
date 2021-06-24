<?php
defined('BASEPATH') or exit('No direct script access allowed');

require_once APPPATH . '/libraries/REST_Controller.php';

class Setting extends REST_Controller
{
    public function __construct()
    {
        parent::__construct();
        $this->load->model(['sells', 'selldetails',
        'porders','suppliers',
            'users', 'books', 'imports']);
    }

    public function index_get()
    {
        $this->data['suppliers'] = $this->suppliers->count_all();
        $this->data['users'] = $this->users->count_all();
        $this->data['porders'] = $this->porders->count_all();
        $this->data['imports'] = $this->imports->count_all();
        $this->response($this->data);
    }

    public function index_post()
    {

    }

    public function index_put()
    {

    }

    public function index_delete($id = 0)
    {

    }

}
