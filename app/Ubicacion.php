<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Ubicacion extends Model
{
    //
    protected $table = 'ubicacion';
    public $timestamps = false;
    protected $primayKey='id';
    protected $fillable = [
        'id',
        'nombre',
        'x',
        'y', 
    ]; 
}
