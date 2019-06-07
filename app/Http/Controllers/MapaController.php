<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use App\Cliente;
use App\Ubicacion;
use App\Personal;
use App\Nota_servicio;
use App\Marcado;


use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Input;

class MapaController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        //
        $nota=DB::table('nota_servicio as n')
        ->join('cliente as c','n.id_cliente','=','c.id')
        ->join('personal as p','n.id_personal','=','p.id')
        ->select('c.nombre as cliente','n.descripcion','n.fecha_hora','p.nombre as personal','n.estado')
        ->orderBy('n.id')->get();
        
        //dd($servicio);
        //return $servicio->toJson();
        return view('crud.servicio.index',compact('nota'));


    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create()
    {
        //
        $personal=DB::table('personal')->where('estado','=','0')->get();

        $cliente=DB::table('cliente')->get();
        $ubicacion=DB::table('ubicacion')->get();
        return view('crud.servicio.create',['personal'=>$personal,'cliente'=>$cliente,'ubicacion'=>$ubicacion]);
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
        $servicio=new Nota_servicio($request->all());
        $servicio->id_cliente=$request->get('id_cliente');
        $servicio->descripcion=$request->get('descripcion');
        
        $servicio->fecha_hora=$request->get('fecha_hora');
        $servicio->id_personal=$request->get('id_personal');
        $servicio->estado='1';
        $servicio->save();
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
    }

    public function person(){


     

        $personal=DB::table('personal as p')
        
        ->join('marcado as m','m.id_personal','=','p.id')
        ->join('ubicacion as u','u.id','=','m.id_ubicacion')
        ->select('p.nombre as personal','u.nombre as ubicacion','u.x as longitud','u.y as latitud')
        ->where('p.estado','=','1')
        ->get();
        

        $original_json_string = $personal->toJson();
        $original_data = json_decode($original_json_string, true);
        $coordinates = array();
        $coord = array();
        foreach($original_data as $key => $value) {
            $coord[] = array('latitud' => $value['latitud'], 'longitud' => $value['longitud']);
        }


        $dato=array();
        foreach($original_data as $key => $value) {
        $dato[]=array(
            'type' => 'Feature',
            'geometry' => array('type' => 'Point', 'coordinates' => array( $value['latitud'],$value['longitud'])),
            'properties' => array('name' => 'value'),
        )
    
        ;
        }
        $new_dato=array();
        $new_dato = array(
            'type' => 'FeatureCollection',
            'features' => $dato,
        );


        $new_data = array(
            'type' => 'FeatureCollection',
            'features' => array(
                'type' => 'Feature',
                'geometry' => array('type' => 'Point', 'coordinates' => $coord),
                'properties' => array('name' => 'value'),
            ),
        );

       
        $final_data = json_encode($new_dato, JSON_PRETTY_PRINT);
        //$final_data = json_encode($new_data, JSON_PRETTY_PRINT);

        //print_r($final_data);

        //dd($servicio);
        //return $personal->toJson();
        return $final_data;
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
