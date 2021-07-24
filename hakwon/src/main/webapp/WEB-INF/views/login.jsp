<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<link href="https://fonts.googleapis.com/css?family=Roboto:100,300,400,500,700,900" rel="stylesheet">
	<link href="https://cdn.jsdelivr.net/npm/@mdi/font@4.x/css/materialdesignicons.min.css" rel="stylesheet">
	<link href="https://cdn.jsdelivr.net/npm/vuetify@2.x/dist/vuetify.min.css" rel="stylesheet">
	<script src="https://unpkg.com/axios/dist/axios.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
	<script src="https://code.jquery.com/jquery-3.6.0.slim.js" integrity="sha256-HwWONEZrpuoh951cQD1ov2HUK5zA5DwJ1DNUXaM6FsY=" crossorigin="anonymous"></script>
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no, minimal-ui">
	
	<style>
	#inspire{width: 50%;
		position: relative;
		left: 33%;}
	</style>
</head>

<body>
	
	<div id="app">
	<v-app id="inspire">
		<v-form ref="form" v-model="valid" lazy-validation>
		
			<v-text-field v-model="name" :counter="10" :rules="nameRules" label="Name" required></v-text-field>
			
			<v-text-field v-model="password" :rules="passwordRules" :type="'password'" label="Password" hint="At least 8 characters"></v-text-field>
	
			<v-text-field v-model="email" :rules="emailRules" label="E-mail" required></v-text-field>
	
			<v-select v-model="select" :items="items" :rules="[v => !!v || 'Item is required']" label="Item" required ></v-select>
	
			<v-checkbox v-model="checkbox" :rules="[v => !!v || 'You must agree to continue!']" label="Do you agree?" required ></v-checkbox>
	
			<v-btn :disabled="!valid" color="success" class="mr-4" @click="validate" >가입</v-btn>
	
			<v-btn color="error" class="mr-4" @click="reset">초기화</v-btn>
			
			<v-btn class="mr-4" @click="getLocation">위치찾기</v-btn>
			
			
			<v-select v-model="sido" :items="sidoList" label="시도" item-text="sido_name" item-value="sido_cd" @change="loadSigungu($event)"></v-select>
			
			<v-select v-model="sigungu" :items="sigunguList" label="시군구"  item-text="sido_name" item-value="sido_cd" 
			></v-select>
			
			
	
		</v-form>
	</v-app>
</div>

	<script src="https://cdn.jsdelivr.net/npm/vue@2.x/dist/vue.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/vuetify@2.x/dist/vuetify.js"></script>
	<script>
	var sigunguList;
	
	var app = new Vue({
		el: '#app',
		vuetify: new Vuetify(),
		data: () => ({
			valid: true,
			name: '',
			nameRules: [
				v => !!v || 'Name is required',
				v => (v && v.length <= 10) || 'Name must be less than 10 characters',
			],
			password: '',
			passwordRules: [
				v => !!v || 'Password is required',
				v => (v && v.length <= 10) || 'Password must be less than 10 characters',
			],
			email: '',
			emailRules: [
				v => !!v || 'E-mail is required',
				v => /.+@.+\..+/.test(v) || 'E-mail must be valid',
			],
			select: null,
			items: [
				'Item 1',
				'Item 2',
				'Item 3',
				'Item 4',
			],
			/* sido: null,
			sidoList:sidoList, */
			sido: null,
			sidoList: ${sidoList},
			sigungu: null,
			sigunguList: sigunguList,
			checkbox: false, 
		}),

		methods: {
			validate () {
				this.$refs.form.validate();
				
				this._data.login_dttm = new Date().toUTCString();
				
				axios.post('/login_process',this._data)
				.then(function(res){
					console.log("res",res);
					
					if(res.status == 200){
						console.log("로그인성공했구");
						location.href = '/main';
					}
					
				})
			},
			reset () {
				this.$refs.form.reset()
			},
			getLocation(){
				navigator.geolocation.getCurrentPosition(function(pos) {
				    var latitude = pos.coords.latitude;
				    var longitude = pos.coords.longitude;
				    alert("현재 위치는 : " + latitude + ", "+ longitude);
				});
			},
			loadSigungu(event){
				
				console.log("이벤트",event);
				console.log("여기에 구현하세요",this._data);//this._data.sido에 sido값 들어있으니 얘를 post로 넘겨서
				axios.post('/getSigungu',this._data).then(function(res){
					console.log("또 res",res);
					console.log("이전",sigunguList)
					app.sigunguList = res.data;
				}).catch(function(res){
					console.log("catch res",res);
				}).finally(function(res){
					console.log("이후",app.sigunguList)
					
				})
				
				
				
			},
		},
	});
	
	console.log("app",app);
	</script>
</body>
</html>