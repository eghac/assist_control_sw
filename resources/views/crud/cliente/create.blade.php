@extends('layouts.principal')
@section('content')


<style>
    .coordinates {
    background: rgba(0,0,0,0.5);
    color: #fff;
    position: absolute;
    bottom: 40px;
    left: 10px;
    padding:5px 10px;
    margin: 0;
    font-size: 11px;
    line-height: 18px;
    border-radius: 3px;
    display: none;
    }
    </style>
<div class="clearfix"></div>
<div class="row">
  <div class="col-md-12 col-sm-12 col-xs-12">
    <div class="x_panel">
      <div class="x_title">
        <h2>Formulario Registro </h2>
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
        <br />
        <form id="demo-form2"  action="{{route('cliente.store')}}" method="POST" enctype="multipart/form-data"  data-parsley-validate class="form-horizontal form-label-left">
            <input type="hidden" name="_token" id="csrf-token" value="{{ Session::token() }}" />
          <div class="form-group">
            <label class="control-label col-md-3 col-sm-3 col-xs-12" for="nombre">Nombre Completo <span class="required">*</span>
            </label>
            <div class="col-md-6 col-sm-6 col-xs-12">
              <input type="text" id="nombre" name="nombre" required="required" class="form-control col-md-7 col-xs-12">
            </div>
          </div>
          <div class="form-group">
            <label class="control-label col-md-3 col-sm-3 col-xs-12" for="cedula">Id Ubicacion <span class="required">*</span>
            </label>
            <div class="col-md-6 col-sm-6 col-xs-12">
              @foreach ($ubicacion as $item) 
              <input type="text" id="id_ubicacion" name="id_ubicacion" value="{{$item->id}}" required="required" class="form-control col-md-7 col-xs-12">
              @endforeach
            </div>
          </div>
          <div class="form-group">
            <label class="control-label col-md-3 col-sm-3 col-xs-12" for="huella">Telefono <span class="required">*</span>
            </label>
            <div class="col-md-6 col-sm-6 col-xs-12">
              <input type="text" id="telefono" name="telefono" required="required" class="form-control col-md-7 col-xs-12">
            </div>
          </div>





          <div class="ln_solid"></div>
          <div class="form-group">
            <div class="col-md-6 col-sm-6 col-xs-12 col-md-offset-3">
                    <a button class="btn btn-danger" a href="<?=$_SERVER["HTTP_REFERER"]?>">Atras</a>     
              
              <button class="btn btn-primary" type="reset">Reset</button>
              <button type="submit" class="btn btn-success">Registrar</button>
            </div>
          </div>

        </form>
      </div>
    </div>
  </div>
</div>






@stop