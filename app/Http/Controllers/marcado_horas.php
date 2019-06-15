<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Marcado;
use App\Personal;
use App\Contrato;
use App\Horas_extras;
use App\Horario;
use App\Ubicacion;
use App\Cliente;
use App\Total;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Input;
use App\Services\PayUService\Exception;

class MarcadoController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        //
     
            //
            $horas=DB::table('marcado as m')
            ->join('personal as p','p.id','=','m.id_personal')
            ->select('p.nombre as nombre','m.fecha','m.hora')
            ->where('m.tipo','=','0')
            ->orderBy('m.id')->get();
                    
            //dd($personal);
            //return $personal->toJson();
            return view('crud.horas_a.index',compact('horas'));
       
    


    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create()
    {
        //
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

       
       


        $ubicacion=new Ubicacion($request->all());
        $ubicacion->nombre='marcado';
        $ubicacion->x=$request->get('x');
        $ubicacion->y=$request->get('y');
        $ubicacion->save();

        $id_ubi= DB::table('ubicacion as u')
        ->select('u.id as id')
        ->orderBy('u.id','desc')->first();
        

        


        $marcado=new Marcado($request->all());
        $marcado->id_personal=$request->get('id_personal');
        $marcado->fecha=$request->get('fecha');
        $marcado->tipo=$request->get('tipo');
        $marcado->id_ubicacion=$id_ubi->id;
        $marcado->hora=$request->get('hora');
        $marcado->id_nota=$request->get('id_nota');;

        if($marcado->save()) {
            return response()->json([
                'message' => 'la marcacion es valida',
                'status_code' => 200
            ]);
        } else {
            return response()->json([
                'message' => 'la marcacion no es valida',
                'status_code' => 400
            ]);
        }


    }

    /**
     * Display the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function show()
    {
        //
      /*  $cliente=DB::table('cliente as c')
        ->join('ubicacion as u','c.id_ubicacion','=','u.id')
        ->select('c.nombre','u.nombre as ubicacion','c.telefono')
        ->orderBy('c.id')->get();*/

      /*  $id_ubi= DB::table('ubicacion as u')
        ->select('u.id as ide')
        ->orderBy('u.id')->first();
        dd( $id_ubi) ;*/

       
        //dd($personal);
        
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
