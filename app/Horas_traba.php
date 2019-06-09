<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Horas_traba extends Model
{
    //
    protected $table = 'horas_trabaja';
    public $timestamps = false;
    protected $primayKey='id';
    protected $fillable = [
        'tipo',
        'fecha_ini', 
        'id_personal',
        'monto',
        'total',  
    ]; 
}
