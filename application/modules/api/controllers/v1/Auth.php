<?php
defined('BASEPATH') or exit('No direct script access allowed');

require_once APPPATH . '/libraries/REST_Controller.php';

class Auth extends REST_Controller
{

    public function __construct()
    {
        parent::__construct();

    }

    public function index_get()
    {
        $data['status'] = true;
        $data['message'] = 'success';

        // $data['id'] = 1;
        // $data['token'] = AUTHORIZATION::generateToken($data);
        $this->data['user'] = $this->getToken();

        $this->response($this->data);
    }

    public function index_post()
    {
        $this->load->model('users');
        $email = $this->post('username');
        $pwd = $this->post('password');

        if (!$email) {
            $this->data['message'] = 'email not found';
            $this->response($this->data, 204);
        }

        if (!$pwd) {
            $this->data['message'] = 'password not found';
            $this->response($this->data, 204);
        }

        $row = $this->users->get_by(['username' => $email]);

        if ($row) {
            // if($row->block==false) {
            if (password_verify($pwd, $row->password)) {
                $data['id'] = $row->id;
                $data['email'] = $row->email;

                $this->data['user'] = $row;
                $row->password = null;
                $this->data['token'] = AUTHORIZATION::generateToken($row);
                $this->response($this->data);
            }
        } else {

            $this->load->model('customers');

            $cus = $this->customers->get_by('email', $email);
            if ($cus) {
                $this->data['user'] = $cus;
                if (password_verify($pwd, $cus->password)) {
                    $cus->password = null;
                    $cus->auther = 'customer';
                    $this->data['token'] = AUTHORIZATION::generateToken($cus);
                    $this->response($this->data);
                } else {
                    $this->data['message'] = 'password or email not found';
                    $this->response($this->data, REST_Controller::HTTP_UNAUTHORIZED);
                }
            } else {
                $this->data['message'] = 'user is blocked';
            }
            $this->response($this->data, REST_Controller::HTTP_UNAUTHORIZED);
        }

    }

    public function logout_post()
    {
        # code...
        $this->data['status'] = true;
        $this->response($this->data);
    }

    public function refresh_post()
    {
        $this->data['user'] = $this->getToken();
        $this->data['token'] = AUTHORIZATION::generateToken($this->data['user']);
        $this->response($this->data);
    }

}

/* End of file Auth.php */
/* Location: ./application/modules/api/v1/controllers/Auth.php */
