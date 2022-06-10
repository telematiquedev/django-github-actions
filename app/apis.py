from rest_framework import serializers
from rest_framework.generics import ListAPIView


from .models import Sample


class SampleListAPIView(ListAPIView):
    queryset = Sample.objects.all()

    class SampleSerializer(serializers.ModelSerializer):
        text = serializers.CharField()

        class Meta:
            model = Sample
            fields = (
                "id",
                "text",
            )

    def get_serializer_class(self):
        return self.SampleSerializer
