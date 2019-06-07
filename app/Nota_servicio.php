<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Nota_servicio extends Model
{
    //
    protected $table = 'nota_servicio';
    public $timestamps = false;
    protected $primayKey='id';
    protected $fillable = [
        'id_cliente',
        'descripcion',
        'fecha_hora', 
        'id_personal',
        'estado', 
    ]; 
}
