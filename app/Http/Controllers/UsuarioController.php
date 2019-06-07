<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use App\Cargo;
use App\Personal;
use App\User;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Input;
use App\Services\PayUService\Exception;
use Illuminate\Support\Facades\Hash;

class UsuarioController extends Controller
{
    public function signup(Request $request)
    {

        $user = User::create([
            'name' => $request['nombre'],
            'email' => $request['email'],
            'password' => Hash::make($request['password']),
        ]);  

        $personal=new Personal($request->all());
        $personal->nombre=$request->get('nombre');
        $personal->cedula=$request->get('cedula');
        $personal->huella=$request->get('huella');
        if(Input::hasfile('foto')){
            $file=Input::file('foto');
            $file->move(public_path().'/imagenes/personal', $file->getClientOriginalName());
            $personal->foto=$file->getClientOriginalName();
        }

       /* $personal->id_cargo=$request->get('id_cargo');*/
        $personal->estado='1';
        $personal->id_usuario=$user->id;
        $personal->save();
    }
}