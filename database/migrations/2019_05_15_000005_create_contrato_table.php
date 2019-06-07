<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreateContratoTable extends Migration
{
    /**
     * Schema table name to migrate
     * @var string
     */
    public $set_schema_table = 'contrato';

    /**
     * Run the migrations.
     * @table contrato
     *
     * @return void
     */
    public function up()
    {
        if (Schema::hasTable($this->set_schema_table)) return;
        Schema::create($this->set_schema_table, function (Blueprint $table) {
            $table->engine = 'InnoDB';
            $table->increments('id');
            $table->string('nombre', 50);
            $table->integer('id_personal')->unsigned();
            $table->integer('tarifa');
            $table->date('fecha_ini');
            $table->date('fecha_fin')->nullable()->default(null);
            $table->integer('id_horario')->unsigned();

            $table->index(["id_horario"], 'fk_contrato_horario');

            $table->index(["id_personal"], 'fk_contrato_personal');


            $table->foreign('id_horario', 'fk_contrato_horario')
                ->references('id')->on('horario')
                ->onDelete('restrict')
                ->onUpdate('restrict');

            $table->foreign('id_personal', 'fk_contrato_personal')
                ->references('id')->on('personal')
                ->onDelete('restrict')
                ->onUpdate('restrict');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
     public function down()
     {
       Schema::dropIfExists($this->set_schema_table);
     }
}
