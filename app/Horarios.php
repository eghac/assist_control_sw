<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Horarios extends Model
{
    //
    protected $table = 'horario';
    public $timestamps = false;
    protected $primayKey='id';
    protected $fillable = [
        'nombre',
        'inicio',
        'fin', 
    ]; 
}
