<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use App\Cargo;
use App\Personal;

use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Input;

class PersonalController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        //
        $personal=DB::table('personal as p')
        ->join('cargo as c','p.id_cargo','=','c.id')
        ->select('p.nombre','p.cedula','p.foto','c.nombre as cargo')
        ->orderBy('p.id')->get();
                
        //dd($personal);
        //return $personal->toJson();
        return view('crud.personal.index',compact('personal'));
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create()
    {
        //
        $cargo=DB::table('cargo')->get();
        return view('crud.personal.create',['cargo'=>$cargo]);
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        //
 
        $personal=new Personal($request->all());
        $personal->nombre=$request->get('nombre');
        $personal->cedula=$request->get('cedula');
        $personal->huella=$request->get('huella');
        if(Input::hasfile('foto')){
            $file=Input::file('foto');
            $file->move(public_path().'/imagenes/personal', $file->getClientOriginalName());
            $personal->foto=$file->getClientOriginalName();
        }

        $personal->id_cargo=$request->get('id_cargo');
        $personal->estado='0';


        $personal->save();
        //dd($personal);
        return redirect('personal');
    }

    /**
     * Display the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function show($id)
    {
        //
        $personal=DB::table('personal as p')
     
        ->select('p.id','p.nombre','p.cedula','p.huella','p.foto','p.id_cargo','p.estado')               
        ->where('p.id','=',$id)->get();
        return $personal->toJson();
        
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function edit($id)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, $id)
    {
        //
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        //
    }
}
