package
{

	import org.apache.royale.reflection.getClassByAlias;
	import org.apache.royale.reflection.utils.getMembersWithNameMatch;
	import org.apache.royale.utils.Proxy;
	import org.apache.royale.reflection.describeType;
	import org.apache.royale.reflection.TypeDefinition;
	import org.apache.royale.reflection.MethodDefinition;
	import org.apache.royale.reflection.ParameterDefinition;
//	import flash.utils.flash_proxy;
	import org.apache.royale.reflection.getDefinitionByName;
	import org.apache.royale.reflection.getQualifiedClassName;

	import mx.rpc.http.HTTPService;

	public dynamic class ExtServiceProxy extends Proxy
	{

		private var _service : HTTPService;

		private var _baseURL : String;

		private var _mark : String;

		private var _typeInfo : TypeDefinition;

		private var _serviceName : String;

		public function ExtServiceProxy( type : Class, service : HTTPService, mark : String, baseURL : String )
		{
			_service = service;
			_baseURL = baseURL;
			_mark = mark;
			_typeInfo = describeType( type );
			_serviceName = _typeInfo.qualifiedName;
		}

		override /*flash_proxy*/ function callProperty( methodName : *, ... args:Array) : *
		{
			// look for method

			var mL:Array = getMembersWithNameMatch(_typeInfo.methods, methodName.toString() )

			//var mL : XMLList = _typeInfo.factory.method.( @name == methodName.toString() );

			if( !mL.length )
			{
				throw new MethodNotFoundException( methodName, _serviceName );
			}
// check correct number of arguments
			var method : MethodDefinition = mL[ 0 ] as MethodDefinition;
			/*// check correct number of arguments
			var method : XML = mL[ 0 ] as XML;*/



			var aL : Array = method.parameters;

			if( aL.length != args.length )
			{
				throw new IncorrectArgumentsException( "Wrong number of arguments. Expected <" + aL.length + "> got <" + args.length + "> in '" + _serviceName + "." + methodName + "()'" );
			}

			// check arguments are correct type
			for( var i : int = 0; i < args.length; i++ )
			{
				var arg : * = args[ i ];
				var requiredType : Class = ParameterDefinition( aL[ i ]).type.getClass();

				if( !( arg is requiredType ) )
				{
					throw new IncorrectArgumentsException( "Wrong argument type for argument '" + ( i + 1 ) + "'. Expected <" + requiredType + "> got <" + getQualifiedClassName( arg ) + ">" );
				}
			}

			var url : String = _baseURL + _serviceName.split( "::" )[ 1 ] + ".cgi";

			// return new request
			return new ExtRpcRequest( _service, url, _mark, methodName, args );

		}

	}
}
