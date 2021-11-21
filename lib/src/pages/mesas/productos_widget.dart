import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:ventas_restobar/src/bloc/index_mesa_bloc.dart';
import 'package:ventas_restobar/src/bloc/provider.dart';
import 'package:ventas_restobar/src/models/familias_model.dart';
import 'package:ventas_restobar/src/models/productos_familia_model.dart';
import 'package:ventas_restobar/src/utils/constants.dart';

class ProductoFamilia extends StatefulWidget {
  const ProductoFamilia({Key key}) : super(key: key);

  @override
  _ProductoFamiliaState createState() => _ProductoFamiliaState();
}

class _ProductoFamiliaState extends State<ProductoFamilia> {
  final _controller = IndexController();
  @override
  Widget build(BuildContext context) {
    final familiasBloc = ProviderBloc.familias(context);
    familiasBloc.obtenerFamilias();
    final provider = Provider.of<IndexMesasBlocListener>(context, listen: false);
    final productosFamiliaBloc = ProviderBloc.productos(context);
    return ValueListenableBuilder(
        valueListenable: provider.vista,
        builder: (BuildContext context, EnumIndex data, Widget child) {
          return Row(
            children: [
              Container(
                width: ScreenUtil().setWidth(328),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        IconButton(
                            onPressed: () {
                              provider.changeToMesas();
                            },
                            icon: Icon(Icons.arrow_back_ios),
                            color: Color(0XFFC4C8C9),
                            iconSize: ScreenUtil().setHeight(24)),
                        Text(
                          'Categorías',
                          style: Theme.of(context).textTheme.button.copyWith(
                                color: kTitleTextColor,
                                fontSize: ScreenUtil().setSp(24),
                                fontWeight: FontWeight.w600,
                              ),
                        )
                      ],
                    ),
                    Expanded(
                      child: StreamBuilder(
                        stream: familiasBloc.familiasStream,
                        builder: (context, AsyncSnapshot<List<FamiliasModel>> snapshot) {
                          if (snapshot.hasData) {
                            if (snapshot.data.length > 0) {
                              var datos = snapshot.data;
                              if (_controller.index == 0) {
                                productosFamiliaBloc.obtenerProductosPorIdFamilia(datos[0].idFamilia);
                              }

                              return ListView.builder(
                                  padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(24)),
                                  itemCount: datos.length,
                                  scrollDirection: Axis.vertical,
                                  itemBuilder: (context, index) {
                                    return InkWell(
                                      onTap: () {
                                        productosFamiliaBloc.obtenerProductosPorIdFamilia(datos[index].idFamilia);
                                        _controller.channgeIndex(index);
                                      },
                                      child: Padding(
                                        padding: EdgeInsets.only(bottom: ScreenUtil().setHeight(24)),
                                        child: AnimatedBuilder(
                                            animation: _controller,
                                            builder: (_, s) {
                                              return Container(
                                                  padding: EdgeInsets.all(ScreenUtil().setHeight(16)),
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(8),
                                                    color: (_controller.index == index) ? Color(0XFFFFE4D0) : Colors.white,
                                                  ),
                                                  child: Row(
                                                    children: [
                                                      Container(
                                                        height: ScreenUtil().setHeight(50),
                                                        child: SvgPicture.asset('assets/svg/fire.svg'),
                                                      ),
                                                      Text(
                                                        '${datos[index].familiaNombre}',
                                                        style: Theme.of(context).textTheme.button.copyWith(
                                                              color: kTitleTextColor,
                                                              fontSize: ScreenUtil().setSp(16),
                                                              fontWeight: FontWeight.w600,
                                                            ),
                                                      )
                                                    ],
                                                  ));
                                            }),
                                      ),
                                    );
                                  });
                            } else {
                              return Center(
                                child: Text(
                                  'Sin categorías',
                                  style: Theme.of(context).textTheme.button.copyWith(
                                        color: kTitleTextColor,
                                        fontSize: ScreenUtil().setSp(16),
                                        fontWeight: FontWeight.w400,
                                      ),
                                ),
                              );
                            }
                          } else {
                            return Center(
                              child: Text(
                                'Cargando...',
                                style: Theme.of(context).textTheme.button.copyWith(
                                      color: kTitleTextColor,
                                      fontSize: ScreenUtil().setSp(16),
                                      fontWeight: FontWeight.w400,
                                    ),
                              ),
                            );
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: ScreenUtil().setWidth(20),
              ),
              Container(
                width: ScreenUtil().setWidth(328),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: ScreenUtil().setHeight(30),
                    horizontal: ScreenUtil().setWidth(24),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            'Productos',
                            style: Theme.of(context).textTheme.button.copyWith(
                                  color: kTitleTextColor,
                                  fontSize: ScreenUtil().setSp(24),
                                  fontWeight: FontWeight.w600,
                                ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: ScreenUtil().setHeight(24),
                      ),
                      Expanded(
                        child: StreamBuilder(
                          stream: productosFamiliaBloc.productosFamiliaStream,
                          builder: (context, AsyncSnapshot<List<ProductosFamiliaModel>> snapshot) {
                            if (snapshot.hasData) {
                              if (snapshot.data.length > 0) {
                                var datos = snapshot.data;
                                return ListView.builder(
                                    itemCount: datos.length,
                                    scrollDirection: Axis.vertical,
                                    itemBuilder: (context, index) {
                                      return InkWell(
                                        child: Padding(
                                          padding: EdgeInsets.only(bottom: ScreenUtil().setHeight(24)),
                                          child: Container(
                                              //padding: EdgeInsets.all(ScreenUtil().setHeight(16)),
                                              height: ScreenUtil().setHeight(100),
                                              child: Row(
                                                //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Container(
                                                    height: ScreenUtil().setHeight(100),
                                                    width: ScreenUtil().setWidth(100),
                                                    decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color: Colors.white,
                                                      boxShadow: [
                                                        BoxShadow(
                                                          color: Color(0XFF808080).withOpacity(0.25),
                                                          blurRadius: 0.4,
                                                        ),
                                                      ],
                                                    ),
                                                    child: Stack(
                                                      children: [
                                                        Center(
                                                          child: Container(
                                                            height: ScreenUtil().setHeight(75),
                                                            width: ScreenUtil().setWidth(75),
                                                            decoration: BoxDecoration(
                                                              shape: BoxShape.circle,
                                                              color: Colors.white,
                                                              boxShadow: [
                                                                BoxShadow(
                                                                  color: Color(0XFF808080).withOpacity(0.25),
                                                                  blurRadius: 0.4,
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                        Center(
                                                          child: Container(
                                                            height: ScreenUtil().setHeight(50),
                                                            child: SvgPicture.asset('assets/svg/cubiertos.svg'),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                  Container(
                                                    width: ScreenUtil().setWidth(105),
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Spacer(),
                                                        Text(
                                                          '${datos[index].productoNombre}',
                                                          style: Theme.of(context).textTheme.button.copyWith(
                                                                color: kTitleTextColor,
                                                                fontSize: ScreenUtil().setSp(16),
                                                                fontWeight: FontWeight.w400,
                                                              ),
                                                        ),
                                                        Spacer(),
                                                        Text(
                                                          'S/${datos[index].productoPrecio}',
                                                          style: Theme.of(context).textTheme.button.copyWith(
                                                                color: kTextColor,
                                                                fontSize: ScreenUtil().setSp(16),
                                                                fontWeight: FontWeight.w600,
                                                              ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Spacer(),
                                                  Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Spacer(),
                                                      Container(
                                                        width: ScreenUtil().setWidth(40),
                                                        height: ScreenUtil().setHeight(40),
                                                        child: SvgPicture.asset('assets/svg/add.svg'),
                                                      )
                                                    ],
                                                  ),
                                                ],
                                              )),
                                        ),
                                      );
                                    });
                              } else {
                                return Center(
                                  child: Text(
                                    'Sin productos para esta categoría',
                                    style: Theme.of(context).textTheme.button.copyWith(
                                          color: kTitleTextColor,
                                          fontSize: ScreenUtil().setSp(16),
                                          fontWeight: FontWeight.w400,
                                        ),
                                  ),
                                );
                              }
                            } else {
                              return Center(
                                child: Text(
                                  'Cargando...',
                                  style: Theme.of(context).textTheme.button.copyWith(
                                        color: kTitleTextColor,
                                        fontSize: ScreenUtil().setSp(16),
                                        fontWeight: FontWeight.w400,
                                      ),
                                ),
                              );
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        });
  }
}

class IndexController extends ChangeNotifier {
  int index = 0;
  void channgeIndex(int i) {
    index = i;
    notifyListeners();
  }
}
