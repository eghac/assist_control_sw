<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use App\Personal;
use App\Horarios;
use App\Contrato;


use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Input;

class ContratoController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        //
        $contrato=DB::table('contrato as c')
        ->join('personal as p','c.id_personal','=','p.id')
        ->join('horario as h','c.id_horario','=','h.id')
        ->select('c.nombre','p.nombre as personal','c.tarifa','c.fecha_ini','c.fecha_fin','h.nombre as horario')
        ->orderBy('c.id')->get();
                
        //dd($contrato);
        //return $contrato->toJson();
        return view('crud.contrato.index',compact('contrato'));


    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create()
    {
        //
        $personal=DB::table('personal')->where('estado','>=','0')->get();
        $horario=DB::table('horario')->get();
        return view('crud.contrato.create',["personal"=>$personal,"horario"=>$horario]);
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
        $contrato=new contrato($request->all());
        $contrato->nombre=$request->get('nombre');
        $contrato->id_personal=$request->get('id_personal');
        $contrato->tarifa=$request->get('tarifa');
        $contrato->fecha_ini=$request->get('fecha_ini');
        $contrato->fecha_fin=$request->get('fecha_fin');
        $contrato->id_horario=$request->get('id_horario');


        $contrato->save();
        //dd($personal);
        return redirect('contrato');


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
