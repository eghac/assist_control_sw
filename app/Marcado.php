<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Marcado extends Model
{
    //
    protected $table = 'marcado';
    public $timestamps = false;
    protected $primayKey='id';
    protected $fillable = [
        'id_personal',
        'fecha_hora',
        'tipo', 
        'id_ubicacion',
    ]; 
}
