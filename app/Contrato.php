<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Contrato extends Model
{
    //
    protected $table = 'contrato';
    public $timestamps = false;
    protected $primayKey='id';
    protected $fillable = [
        'nombre',
        'id_personal',
        'tarifa', 
        'fecha_ini',
        'fecha_fin', 
        'id_horario',
    ]; 
}
