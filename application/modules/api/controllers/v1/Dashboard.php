<?php
defined('BASEPATH') or exit('No direct script access allowed');

require_once APPPATH . '/libraries/REST_Controller.php';

class Dashboard extends REST_Controller
{
    public function __construct()
    {
        parent::__construct();
        $this->load->model(['sells', 'selldetails', 'users', 'books', 'customers']);
    }

    public function index_get()
    {
        $this->data['orders'] = $this->sells->count_by('status', 'order');
        $this->data['customers'] = $this->customers->count_all();
        $this->data['users'] = $this->users->count_all();
        $this->data['books'] = $this->books->count_all();
        $this->data['sells'] = $this->sells->count_all();
        $this->data['selldetails'] = $this->selldetails->count_all();

        // order recent
        $sql = "select s.*,c.first,c.last from sells s 
         inner join customers c on s.customer_id=c.id where s.status='order' 
        order by sell_date desc  limit 5 ";
        $this->data['recent_orders'] = $this->db->query($sql)->result();

        $sqlSellChart = "SELECT count(id)as total,date_format(sell_date,'%m/%Y') as date FROM `sells` GROUP by date_format(sell_date,'%Y-%m') 
         order by sell_date desc limit 12";
        $this->data['sell_data_chart'] = $this->db->query($sqlSellChart)->result();

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
