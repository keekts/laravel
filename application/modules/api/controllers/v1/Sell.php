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
            $searchSql = " where s.id like '$search%' or c.first like '%$search%' and (s.status='$status') ";
        } else {
            $searchSql = " where s.status='$status'";
        }

        $sql = "select s.*,c.first,c.last from sells s
				inner join customers c on s.customer_id=c.id $searchSql
			 order by sell_date desc  limit $offset,$limit ";
        $this->data['sells'] = $this->db->query($sql)->result();
        $this->data['total'] = $this->sells->count_by('status', $status);

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

    public function report_get()
    {
        $date = $this->get('date') ?? Date('Y-m-d');

        $mode = $this->get('mode') ?? 'day';

        $dayR = explode('-', $date);

        $month = $dayR[0] . '-' . $dayR[1];
        $year = $dayR[0];

        $sqlDay = "select sum(d.price) as total, sum(b.price_cost) as cost
         from sell_details d inner join sells  s on s.id=d.sell_id
         inner join books b on b.id=d.book_id
           where date_format(sell_date,'%Y-%m-%d')='$date' and s.status='sell'";

        $sqlMonth = "select sum(d.price) as total, sum(b.price_cost) as cost
        from sell_details d inner join sells  s on s.id=d.sell_id
         inner join books b on b.id=d.book_id
          where date_format(sell_date,'%Y-%m')='$month' and s.status='sell'";

        $sqlYear = "select sum(d.price) as total, sum(b.price_cost) as cost
        from sell_details d inner join sells  s on s.id=d.sell_id
         inner join books b on b.id=d.book_id
          where date_format(sell_date,'%Y')='$year' and s.status='sell'";

        $_d = array(
            'report'=>'reportDay',
            'on_time'=>$dayR[2].'/'.$dayR[1].'/'.$year,
            'count' => $this->sells->count_by(['status' => 'sell', "date_format(sell_date,'%Y-%m-%d')" => $date]),
            'detail' => $this->db->query($sqlDay)->row(),
        );

        $_m = array(
            'report'=>'reportMonth',
            'on_time'=>$dayR[1].'/'.$year,
            'count' => $this->sells->count_by(['status' => 'sell', "date_format(sell_date,'%Y-%m')" => $month]),
            'detail' => $this->db->query($sqlMonth)->row(),
        );

        $_y = array(
            'report'=>'reportYear',
            'on_time'=>$year,
            'count' => $this->sells->count_by(['status' => 'sell', "date_format(sell_date,'%Y')" => $year]),
            'detail' => $this->db->query($sqlYear)->row(),
        );

        $this->data['items'] = [$_d,$_m,$_y];

        $this->response($this->data);
    }

    public function reportItems_get()
    {

        $date = $this->get('date') ?? Date('Y-m-d');

        $mode = $this->get('mode') ?? 'day';

        $dayR = explode('-', $date);

        $month = $dayR[0] . '-' . $dayR[1];
        $year = $dayR[0];

        switch ($mode) {
            case 'day':
                $wh = "date_format(sell_date,'%Y-%m-%d')='$date'";
                break;
            case 'month':
                $wh = "date_format(sell_date,'%Y-%m')='$month'";
                break;
            case 'year':
                $wh = "date_format(sell_date,'%Y')='$year'";
                break;
            default:
                $wh = "date_format(sell_date,'%Y-%m-%d')='$date'";
                break;
        }

        $sql = "select s.*,c.first,c.phone,c.last,(select sum(price) from sell_details where sell_id=s.id ) as total 
         from sells s inner join customers c on c.id=s.customer_id where $wh  and s.status='sell' order by s.id desc";

        $this->data['sells'] = $this->db->query($sql)->result();

        // $this->data['sql'] = $sql;

        $this->response($this->data);
    }

}
