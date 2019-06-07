<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Horas_extras extends Model
{
    //
    protected $table = 'horas_extras';
    public $timestamps = false;
    protected $primayKey='id';
    protected $fillable = [
        'tipo',
        'fecha_ini',
        'fecha_final', 
        'id_personal',
        'monto', 
    ]; 
}
