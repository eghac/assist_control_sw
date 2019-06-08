<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Total extends Model
{
    //
    protected $table = 'Total';
    public $timestamps = false;
    protected $primayKey='id';
    protected $fillable = [
        'tipo',
        'fecha_ini', 
        'id_personal',
        'monto', 
    ]; 
}
