<?php
defined('BASEPATH') or exit('No direct script access allowed');

require_once APPPATH . '/libraries/REST_Controller.php';

class Cart extends REST_Controller
{
    public function __construct()
    {
        parent::__construct();
        $this->load->model(['sells', 'selldetails']);

    }

    public function index_get()
    {
        $wh = array(
            'status' => 'order',
            'customer_id' => $this->get('id'),
        );
        $row = $this->sells->get_by($wh);
        $this->data['sell'] = $row;
        if ($row) {
            $this->data['items'] = $this->selldetails->items($row->id);
        }
        $this->response($this->data);
    }

    public function index_post()
    {
        $val = $this->post('input');
        $items = $this->post('items');

        $wh = array(
            'status' => 'order',
            'customer_id' => $val['customer_id'],
        );
        $row = $this->sells->get_by($wh);
        if ($row) {
            $id = $row->id;
        } else {
            $id = $this->sells->insert($val);
        }

        foreach ($items as $x) {
            $item = array(
                'book_id' => $x['id'],
                'price' => $x['price'],
                'qty' => $x['qty'],
                'sell_id' => $id,
            );
            $this->selldetails->insert($item);
        }
        $this->data['sell'] = $this->sells->get($id);
        $this->response($this->data);
    }

}
