<?php

require_once('workflows.php');

class Linggle{

    private $url = "http://linggle.com/query/";

    function __construct(){
       
    }

    public function getLinggle($query){
        $workflows = new Workflows();
        $api = $this->url.urlencode($query);
        $res = $workflows->request($api);
        $res = json_decode( $res );
        if ($res) {
            foreach ($res as $key => $values) {
                if ($key < 10) {
                    $workflows->result($values->count,
                                    $values->count,
                                    join(" ", $values->phrase),
                                    $values->percent.", ".$values->count,
                                    "icon.png");
                }
            }
        }else{
            $workflows->result( '',
                                '',
                                '没查到呀', 
                                '没找到对应的Linggle',
                                'icon.png',false);
        }

        echo $workflows->toxml();
    }

}