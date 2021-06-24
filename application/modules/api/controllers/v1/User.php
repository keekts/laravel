<?php
defined('BASEPATH') or exit('No direct script access allowed');

require_once APPPATH . '/libraries/REST_Controller.php';

class User extends REST_Controller
{

    public function __construct()
    {
        parent::__construct();
        $this->load->model('users');
    }

    public function index_get()
    {
        $limit = $this->get('limit') ?: 10;
        $offset = $this->get('offset') ?: 0;
        $this->users->limit($limit, $offset);

        $id = $this->get('id');
        if ($id > 0) {
            $this->data['user'] = $this->users->get($id);
            $this->response($this->data);
        }

        $search = $this->get('search');
		if ($search) {
			$this->db->where(" first LIKE '%$search%' OR phone LIKE '%$search%' ");
		}

        $this->data['users'] = $this->users->get_all();
        $this->response($this->data);
    }

    public function index_post()
    {
        $val = array(
            'first' => $this->post('first'),
            'last' => $this->post('last'),
            'email' => $this->post('email'),
            'username' => $this->post('username'),
            'phone' => $this->post('phone'),
            'address' => $this->post('address'),
            'age' => $this->post('age'),
            'gender' => $this->post('gender') ?: 'F',
            'password' => $this->post('password'),
            'auther' => $this->post('auther') ?: 'User',
        );

        if (strlen($val['password']) < 4) {
            $this->data['message'] = 'password min legnth';
            $this->response($this->data, 400);
        }

        if (!$val['email']) {
            $this->data['message'] = 'email empty';
            $this->response($this->data, 400);
        }

        // check email
        $row = $this->users->get_by(['email' => $val['email']]);
        if ($row) {
            $this->data['message'] = 'user ready exit';
            $this->response($this->data, 400);
        } else {
            $val['password'] = password_hash($val['password'], PASSWORD_DEFAULT);
            $this->data['message'] = 'success';
            $id = $this->users->insert($val);
            $this->data['user'] = $this->users->get($id);
            $this->response($this->data, 201);
        }
    }

    public function index_put()
    {
        # update
        $data = $this->put('input');

        $allowed = ['username','first', 'last', 'age', 'address', 'gender', 'auther', 'email', 'password', 'phone'];

        $id = trim($this->put('id'));

        if (!$id) {
            $this->data['message'] = 'id not value !';
            $this->response($this->data, 400);
        }

        $user = array_filter(
            $data,
            function ($key) use ($allowed) {
                return in_array($key, $allowed);
            },
            ARRAY_FILTER_USE_KEY
        );

        if (array_key_exists('password', $user)) {
            // encode password
            if (strlen($user['password']) > 3) {
                $user['password'] = password_hash($user['password'], PASSWORD_DEFAULT);
            }
        }

        $this->users->update($id, $user);

        $this->data['user'] = $this->users->get($id);
        $this->response($this->data);
    }

    public function changeEmail_put()
    {

    }

    public function profile_post()
    {
        $id = $this->post('id');
        if ($id > 0) {
            $this->load->helper('string');

            //Month in mm format, with leading zeros.
            $month = date("m");
            $directory = "uploads/profile";
            $config['upload_path'] = $directory;
            $config['allowed_types'] = 'gif|jpg|png|jpeg|svg';
            // $config['max_size']             = 100;
            // $config['max_width']            = 1024;
            // $config['max_height']           = 768;
            $config['file_name'] = random_string('alnum', 10);

            $this->load->library('upload', $config);

            if (!$this->upload->do_upload('file')) {
                $this->data['error'] = $this->upload->display_errors();
                $this->response($this->data, 400);
            } else {
                $upload = $this->upload->data();
                //Image Resizing
                $config1['source_image'] = $upload['full_path'];
                // $config1['create_thumb'] = true;
                $config1['width'] = 250;
                $config1['height'] = 300;
                $config1['new_image'] = $directory; //.'/'.$config1['width'].'x'.$config1['height'];
                $config1['maintain_ratio'] = false;
                $upload['folder'] = $directory;
                $this->data['image'] = $upload;

                $this->load->library('image_lib', $config1);
                $this->image_lib->resize();

                // $imgagePath = $upload['folder'] . "/" . $upload['file_name'];
                $imgageCover = $upload['folder'] . "/" . $upload['raw_name'] . $upload['file_ext'];
                // $val['cover'] = $imgageCover;
                $val['photo'] = $imgageCover;

                $user = $this->users->get($id);
                $this->data['user'] = $user;

                if ($user) {
                    if ($user->photo) {
                        // remove old image
                        if (file_exists($user->photo)) {
                            @unlink($user->photo);
                        }
                    }
                }

                $this->users->update($id, $val);

                $this->response($this->data);

            }

        }

        $this->response($this->data, 400);
    }

    public function index_delete($id)
    {
        # delete
        $this->load->model(['sells', 'porders']);
        $sell = $this->sells->count_by('emp_id', $id);
        $porder = $this->porders->count_by('emp_id', $id);
        if ($porder > 0 && $sell > 0) {
            $this->response($this->data, 400);
        } else {
            $user = $this->users->get($id);
            $this->data['user'] = $user;

            if ($user) {
                if ($user->photo) {
                    // remove old image
                    if (file_exists($user->photo)) {
                        @unlink($user->photo);
                    }
                }
            }
            $this->users->delete($id);
            $this->response($this->data);
        }
    }

}
