from rest_framework.decorators import api_view
from rest_framework.response import Response
from .models import Notes
from .serializers import NoteSerializer
from rest_framework import status

@api_view(['GET'])
def ApiOverview(request):
	api_urls = {
		'all_items': '/',
		'Search by Category': '/?category=category_name',
		'Search by Subcategory': '/?subcategory=category_name',
		'Add': '/create',
		'Update': '/update/pk',
		'Delete': '/item/pk/delete'
	}

	return Response(api_urls)

@api_view(['POST'])
def add_items(request):
	note = NoteSerializer(data=request.data)
	if note.is_valid():
		note.save()
		return Response(note.data)
	else:
		return Response(status=status.HTTP_404_NOT_FOUND)

@api_view(['GET'])
def view_notes(request):
	# checking for the parameters from the URL
	if request.query_params:
		notes = Notes.objects.filter(**request.query_params.dict())
	else:
		notes = Notes.objects.all()

	# if there is something in items else raise error
	if notes:
		serializer = NoteSerializer(notes, many=True)
		return Response(serializer.data)
	else:
		return Response(status=status.HTTP_404_NOT_FOUND)

@api_view(['POST'])
def update_items(request, pk):
	note = Notes.objects.get(pk=pk)
	data = NoteSerializer(instance=note, data=request.data)

	if data.is_valid():
		data.save()
		return Response(data.data)
	else:
		return Response(status=status.HTTP_404_NOT_FOUND)

@api_view(['DELETE'])
def delete_items(request, pk):
	item = get_object_or_404(Item, pk=pk) # type: ignore
	item.delete()
	return Response(status=status.HTTP_202_ACCEPTED)
