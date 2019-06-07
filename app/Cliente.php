<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Cliente extends Model
{
    //
    protected $table = 'cliente';
    public $timestamps = false;
    protected $primayKey='id';
    protected $fillable = [
        'nombre',
        'id_ubicacion',
        'telefono', 
    ]; 
}
