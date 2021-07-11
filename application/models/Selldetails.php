<?php
defined('BASEPATH') or exit('No direct script access allowed');

class Selldetails extends MY_Model
{
    public $_table = 'sell_details';

    public function __construct()
    {
        parent::__construct();
    }

    public function items($sellID)
    {
        $sql = "select b.name,b.cover,d.* from books b inner join 
			sell_details d on d.book_id=b.id where sell_id=$sellID";
        return $this->db->query($sql)->result();
    }

}
