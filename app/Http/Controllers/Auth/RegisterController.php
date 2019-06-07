<?php

namespace App\Http\Controllers\Auth;
use App\Personal;
use App\Cargo;
use App\User;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Validator;
use Illuminate\Foundation\Auth\RegistersUsers;
use DB;
use App\Services\PayUService\Exception;

class RegisterController extends Controller
{
    /*
    |--------------------------------------------------------------------------
    | Register Controller
    |--------------------------------------------------------------------------
    |
    | This controller handles the registration of new users as well as their
    | validation and creation. By default this controller uses a trait to
    | provide this functionality without requiring any additional code.
    |
    */

    use RegistersUsers;

    /**
     * Where to redirect users after registration.
     *
     * @var string
     */
    protected $redirectTo = '/home';

    /**
     * Create a new controller instance.
     *
     * @return void
     */
    public function __construct()
    {
        $this->middleware('guest');
    }

    /**
     * Get a validator for an incoming registration request.
     *
     * @param  array  $data
     * @return \Illuminate\Contracts\Validation\Validator
     */
    protected function validator(array $data)
    {
        return Validator::make($data, [
            'name' => 'required|string|max:255',
            'email' => 'required|string|email|max:255|unique:users',
            'password' => 'required|string|min:6|confirmed',
        ]);
    }

    /**
     * Create a new user instance after a valid registration.
     *
     * @param  array  $data
     * @return \App\User
     */
    protected function create(array $request)
    {
        DB::beginTransaction();

        try {

            $user = User::create([
                'name' => $request['nombre'],
                'email' => $request['email'],
                'password' => Hash::make($data['password']),
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

        } catch (Exception $e) {
            DB::rollBack();
        }

        DB::commit();
        
        return $user;

    //     $personal=new Personal($request->all());
    //     $personal->nombre=$request->get('nombre');
    //     $personal->cedula=$request->get('cedula');
    //     $personal->huella=$request->get('huella');
    //     if(Input::hasfile('foto')){
    //         $file=Input::file('foto');
    //         $file->move(public_path().'/imagenes/personal', $file->getClientOriginalName());
    //         $personal->foto=$file->getClientOriginalName();
    //     }

    //    /* $personal->id_cargo=$request->get('id_cargo');*/
    //     $personal->estado='1';
    //     $personal->id_usuario=$request->get('id_usuario');


    //     $personal->save();

    //     return User::create([
    //         'name' => $data['name'],
    //         'email' => $data['email'],
    //         'password' => Hash::make($data['password']),
    //     ]);   
    }

    public function signup(Request $request)
    {

        $user = User::create([
            'name' => $request['nombre'],
            'email' => $request['email'],
            'password' => Hash::make($data['password']),
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
