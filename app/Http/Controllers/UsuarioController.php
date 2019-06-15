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
        $personal->estado='0';
        $personal->id_user=$user->id;

        

        


        if($personal->save()) {
            $id_p= DB::table('personal as p')
        ->select('p.id as id')
        ->orderBy('p.id', 'desc')->first();
            return response()->json([
                'id'=>$id_p->id,
                'nombre'=>$personal->nombre,
                'email'=>$user->email,
                'cedula'=>$personal->cedula,
                'huella'=>$personal->huella,
                'message' => 'El Usuario es valido',
                'status_code' => 200
            ]);
        } else {
            return response()->json([
                'message' => 'EL Usuario no es valida',
                'status_code' => 400
            ]);
        }
    }

    public function show($email,$password)
    {
        //
     
         $hashpassword= DB::table('users as u')
        ->select('u.password')             
        ->where('u.email','=',$email)    
        ->first();

        //$pass=var_dump($hashpassword->password) ;
       // return $pass['1'];
        //return $hashpassword->toJson();
       /* Hash::check('plain-text', $hashedPassword*/
       //if ( Hash::check($password,$hashpassword)) { 
        if ( $hashpassword != null && Hash::check($password,$hashpassword->password)) {
            $datos= DB::table('users as u')
            ->join('personal as p','p.id_user','=','u.id')
        ->select('p.id as id','p.nombre as nombre','p.cedula as cedula','p.huella as huella')             
        ->where('u.email','=',$email)    
        ->first();


            return response()->json([
                'id'=>$datos->id,
                'nombre'=>$datos->nombre,
                'email'=>$email,
                'cedula'=>$datos->cedula,
                'huella'=>$datos->huella,
                'message' => 'los campos son valida',
                'status_code' => 200
            ]);
        } else {
            return response()->json([
                'message' => 'los campos no son valida',
                'status_code' => 400
            ]);
        }
/*
        return $contrato->toJson();

        if ($contrato > '0') {
            return response('Correcto', 200);
        }*/
        abort(400, 'Esta acción no está autorizada.');
        //return $contrato->toJson();
    }
}