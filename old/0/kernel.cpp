int main(){
	return 1;
}

extern "C" void start(){
	*(char*)0xb8000 = 'Q';

	return;
}
