from django.db import models

class Notes(models.Model):
	title=models.CharField(max_length=100)
	content=models.CharField(max_length=10000000000)

	def __str__(self) -> str:
		return self.title
