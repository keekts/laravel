<?php
defined('BASEPATH') or exit('No direct script access allowed');

require_once APPPATH . '/libraries/REST_Controller.php';

class Welcome extends REST_Controller
{
    public function __construct()
    {
        parent::__construct();
        $this->load->model('customers');

    }

    public function index_get()
    {
        $this->data['message'] = 'API Version 1.0';
        $this->data['data'] = '';
        $this->response($this->data);
    }

    public function profile_get()
    {
        $id = $this->get('id');
        $this->data['user'] = $this->customers->get($id);
        $this->response($this->data);
    }

    public function register_post()
    {
        $val = $this->post('input');

        if (!$val['password']) {
            $this->data['status'] = false;
            $this->data['label'] = 'no_password';
            $this->response($this->data);
        }

        if (!$val['email']) {
            $this->data['status'] = false;
            $this->data['label'] = 'no_email';
            $this->response($this->data);
        }

        // check email
        $row = $this->customers->get_by('email', $val['email']);
        if ($row) {
            $this->data['status'] = false;
            $this->data['label'] = 'have_email';
            $this->response($this->data);
        }

        $this->data['status'] = true;

        $val['password'] = password_hash($val['password'], PASSWORD_DEFAULT);

        $id = $this->customers->insert($val);
        $this->data['user'] = $this->customers->get($id);
        $this->response($this->data);
    }

    public function index_put()
    {
        $val = $this->put('input');
        $id = $this->put('id');
        $this->customers->update($id, $val);

        $this->data['user'] = $this->customers->get($id);
        $this->response($this->data);
    }

}
