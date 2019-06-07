@extends('layouts.principal')
@section('content')
<div class="col-md-12 col-sm-12 col-xs-12">
        <div class="x_panel">
          <div class="x_title">
            <h2>Lista de Personal </h2>
            <ul class="nav navbar-right panel_toolbox">
              <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
              </li>
              <li class="dropdown">
                <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false"><i class="fa fa-wrench"></i></a>
                <ul class="dropdown-menu" role="menu">
                  <li><a href="#">Settings 1</a>
                  </li>
                  <li><a href="#">Settings 2</a>
                  </li>
                </ul>
              </li>
              <li><a class="close-link"><i class="fa fa-close"></i></a>
              </li>
            </ul>
            <div class="clearfix"></div>
          </div>
          <div class="x_content">
            <a href="{{route('personal.create')}}" class="btn btn-success"><i class="fa fa-plus"></i> Agregar Personal</a>
            <p class="text-muted font-13 m-b-30">
              Dar click al Boton Agregar Personal.
            </p>
            <div class="table-resonsive">

            <table id="datatable-buttons" class="table table-striped table-bordered table-condensed table-hover">
              <thead>
                <tr>
                
                  <th>Foto</th>
                  <th>Nombre</th>
                  <th>Cedula</th>
                  <th>Cargo</th>
                  <th>Operaciones</th>
                </tr>
              </thead>
              <tbody>
                    @foreach($personal as $p )
                    <tr>
                        <td align="center" WIDTH="50" ><img src="{{asset('imagenes/personal/'.$p->foto)}}" r6="true" height="100px" width="100px" class="profile_img"></td>
                        <td>{{$p->nombre}}</td>
                        <td>{{$p->cedula}}</td>
                        <td>{{$p->cargo}}</td>
                        <td>hola</td>

                    </tr>
                    @endforeach

              </tbody>
            </table>
            </div>
          </div>
        </div>
      </div>

@stop